#Retrieve the web, DB and test server's IP addresses
managementIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' management_node)
data1IP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' data_node1)
data2IP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' data_node2)
mysqlIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' mysql_node)

echo "Management Node setup started"
#Create config.ini file
sudo chmod -R 777 /etc/ansible
cd /etc/ansible/config
echo "[ndbd default]" > config.ini
echo "NoOfReplicas=2" >> config.ini
echo "DataMemory=80M" >> config.ini
echo "IndexMemory=18M" >> config.ini
echo "" >> config.ini

echo "[tcp default]" >> config.ini
echo "portnumber=2202" >> config.ini
echo "" >> config.ini

echo "[ndb_mgmd]" >> config.ini
echo "hostname="$managementIP >> config.ini
echo "datadir=/var/lib/mysql-cluster" >> config.ini
echo "" >> config.ini

echo "[ndbd]" >> config.ini
echo "hostname="$data1IP >> config.ini
echo "datadir=/usr/local/mysql/data" >> config.ini
echo "" >> config.ini

echo "[ndbd]" >> config.ini
echo "hostname="$data2IP >> config.ini
echo "datadir=/usr/local/mysql/data" >> config.ini
echo "" >> config.ini

echo "[mysqld]" >> config.ini
echo "hostname="$mysqlIP >> config.ini
echo "" >> config.ini

echo "config file for management node is changed with the following contents:"
cat config.ini

proxies=$(env | grep proxy | tr '\n' ' ')
proxies=$(echo $proxies | sed 's/welcome%404567/sep%402016/g')
echo "Proxies obtained: "$proxies
cd /etc/ansible
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i hosts -u root Setup_management_node.yml --extra-vars "host=$managementIP $proxies"

echo "DataNode setup started"
#Create my.cnf file
cd /etc/ansible/config
echo "[mysqld]" > my.cnf
echo "ndbcluster" >> my.cnf
echo "" >> my.cnf

echo "[mysql_cluster]" >> my.cnf
echo "ndb-connectstring="$managementIP >> my.cnf
echo "" >> my.cnf

echo "my.cnf file is changed with the following contents:"
cat my.cnf

#proxies=$(env | grep proxy | tr '\n' ' ')
#proxies=$(echo $proxies | sed 's/welcome%404567/sep%402016/g')
#echo "Proxies obtained: "$proxies
cd /etc/ansible
#export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i hosts -u root Setup_Datanode.yml --extra-vars "host=$data1IP $proxies"
ansible-playbook -i hosts -u root Setup_Datanode.yml --extra-vars "host=$data2IP $proxies"

echo "MySQL Node setup started"
ansible-playbook -i hosts -u root Setup_Mysqlnode.yml --extra-vars "host=$mysqlIP $proxies managementIP=$managementIP"

echo "Starting Cluster..."
ansible-playbook -i hosts -u root StartCluster.yml --extra-vars "managementIP=$managementIP data1IP=$data1IP data2IP=$data2IP mysqlIP=$mysqlIP $proxies"

