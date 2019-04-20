@isTest
public class TestCar {
	static void validateCarClass(){
		Car__c car = new Car__c();
		car.price__c= 9;
	    car.tax__c= 15;
	    car.modelYear__c='Juano';
	    car.downPayment__c=121;
	    car.leasing__c=121;
	    car.registrationPlate__c='Pablo';
	    car.Name='Urrea';
	    car.fullPrice__c = car.price__c + car.tax__c;
	   	insert car;
	   	car = [SELECT Name FROM Car__c WHERE Name =:car.Name];
	    System.assertEquals('Urrea', car.Name);
	}
	static void getCarTest(){
		Car__c car = new Car__c();
		car.price__c= 9;
	    car.tax__c= 15;
	    car.modelYear__c='Juano';
	    car.downPayment__c=121;
	    car.leasing__c=121;
	    car.registrationPlate__c='Pablo';
	    car.Name='Urrea';
	    car.fullPrice__c = car.price__c + car.tax__c;
        Car__c car2 = new Car__c();
        car2.price__c= 9;
	    car2.tax__c= 15;
	    car2.modelYear__c='Juano';
	    car2.downPayment__c=121;
	    car2.leasing__c=121;
	    car2.registrationPlate__c='Pablo';
	    car2.Name='Urrea';
	    car2.fullPrice__c = car.price__c + car.tax__c;
        list<Car__c> carList = new list<Car__c>();
        carList.add(car);
        carList.add(car2);
        insert carList;         
        list<Car__c> obj1 = new CarController().getCars();
        system.assertequals(obj1.size(),2);         
        delete carList;         
        list<account> obj2 = new CarController().getCars();
        system.assertEquals(obj2.size(),0);
	}    
}