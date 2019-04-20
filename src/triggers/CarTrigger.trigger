trigger CarTrigger on Car__c (before insert, before update) {
	if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
		List<Car__c> listCar = new List<Car__c>();
		for(Car__c oCar : Trigger.new) {
			if(oCar!= null){
				Car__c car = new Car__c();
		    	car.price__c= oCar.price__c;
		    	car.tax__c= oCar.tax__c;
		    	car.modelYear__c= oCar.modelYear__c;
		    	car.downPayment__c= oCar.downPayment__c;
		    	car.leasing__c= oCar.leasing__c;
		    	car.registrationPlate__c= oCar.registrationPlate__c;
		    	if(oCar.fullPrice__c == 0){
		    		car.fullPrice__c = car.price__c + car.tax__c;		    		
		    	}
		    	listCar.add(car);			
			}    		
	    }				
	}		    
}