package test.java.com.psl.jdbc;

import static org.junit.Assert.*;



import main.java.com.psl.jdbc.dataAccess;

import org.junit.Test;



public class dataAccessTest {

	@Test
	public void testcheckDate() {
		dataAccess da=new dataAccess();
		assertEquals(true, da.checkDate("2016-04-07"));
	}
	
	@Test
	public void testcheckDate1() {
		dataAccess da=new dataAccess();
		assertEquals(false, da.checkDate("2016/04/07"));
	}
	
	/*@Test
	public void testcheckDuplicateCode1() throws ClassNotFoundException {
		dataAccess da=new dataAccess();
		assertEquals(false, da.checkDuplicateCode("a1"));
	}*/
}
