public with sharing class MyCrudController {
    @AuraEnabled
    public static List<Account> getAccounts() {
        // 객체와 필드의 읽기 권한 확인
        if (Schema.sObjectType.Account.isAccessible() &&
            Schema.sObjectType.Account.fields.Name.isAccessible()) {
            
            // 권한 확인 후 SOQL 실행
            return [SELECT Id, Name FROM Account LIMIT 10];
        } else {
            // 권한이 없을 경우 예외 발생
            throw new System.Exception('Access Denied: Insufficient permissions to access Account or its fields.');
        }
    }

    @AuraEnabled
    public static void createAccount(String name) {
        // 객체 생성 권한 확인
        if (Schema.sObjectType.Account.isCreateable() &&
            Schema.sObjectType.Account.fields.Name.isCreateable()) {

            // 권한 확인 후 DML 작업 수행
            Account acc = new Account(Name = name);
            insert acc;
        } else {
            // 권한이 없을 경우 예외 발생
            throw new System.Exception('Access Denied: Insufficient permissions to create Account or its fields.');
        }
    }
}
