@isTest
public class TestLeads {
	static void testClass(){
		Lead oLead = new Lead();
		oLead.firstname='Juan';	
		oLead.lastname='Urrea';	
	    oLead.company='Miami Cars';	
	   	oLead.phone='1212';	
	    oLead.email='juan@mail.com';	
	    oLead.fax='121313';	
	    oLead.status='true';
	    oLead.description ='This is a test';
	   	insert oLead;
	   	oLead = [SELECT firstname FROM Lead WHERE lastname =:oLead.lastname];
	    System.assertEquals('Urrea', oLead.lastname);
	}
	static void getCuentasTest(){
		Lead oLead = new Lead();
		oLead.firstname='Ana Maria';	
		oLead.lastname='Urrea';	
	    oLead.company='Miami Cars';	
	   	oLead.phone='1212';	
	    oLead.email='Maria@mail.com';	
	    oLead.fax='121313';	
	    oLead.status='true';
	    oLead.description ='This is a test';
        Lead oLead1 = new Lead();
		oLead1.firstname='Ricardo';	
		oLead1.lastname='Urrea';	
	    oLead1.company='Miami Cars';	
	   	oLead1.phone='1212';	
	    oLead1.email='ricardo@mail.com';	
	    oLead1.fax='121313';	
	    oLead1.status='true';
	    oLead1.description ='This is a test';
	    list<Lead> leadList = new list<Lead>();
        leadList.add(oLead);
        leadList.add(oLead1);
        insert leadList;         
        list<Lead> obj1 = [select Id, Name from Lead];
        system.assertequals(obj1.size(),2);         
        delete leadList;  
	}    	
}