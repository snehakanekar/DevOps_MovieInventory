
import unittest
import re
from selenium import webdriver
import os

from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait # available since 2.4.0
from selenium.webdriver.support import expected_conditions as EC # available since 2.26.0
from selenium.webdriver.common.by import By

class Test_Home_page(unittest.TestCase):

    def setUp(self):
        self.browser = webdriver.Firefox()

    def testTitle(self):
        self.browser.get('http://10.51.237.131:9001/MovieInventory/') 
	#print(self.browser.page_source)
        self.assertIn('Add Movie Details', self.browser.title)

    def tearDown(self):
        self.browser.quit()


class Test_AddMovie(unittest.TestCase):

    def setUp(self):
        self.browser = webdriver.Firefox()

    def testTitle(self):        
	# Create a new instance of the Firefox driver
	driver = webdriver.Firefox()

	driver.get('http://10.51.237.131:9001/MovieInventory/') 
	#print driver.title

	# find the element that's name attribute is q (the google search box)
	
	driver.find_element_by_xpath("//form/input[1]").click()

	src = driver.page_source
	text_found = re.search(r'Movie code', src)
	self.assertNotEqual(text_found, None)
	driver.quit()

    def tearDown(self):
        self.browser.quit()


if __name__ == '__main__':
     log_file = '/root/test_result.log'
     f = open(log_file, "w")
     runner = unittest.TextTestRunner(f)
     unittest.main(testRunner=runner)
     f.close()
