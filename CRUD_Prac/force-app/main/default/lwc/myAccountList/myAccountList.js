import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/MyCrudController.getAccounts';
import createAccount from '@salesforce/apex/MyCrudController.createAccount';

export default class MyAccountList extends LightningElement {
    accounts;

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            console.error(error);
        }
    }

    createAccount() {
        createAccount({ name: 'New Account' })
            .then(() => {
                return refreshApex(this.wiredAccounts);
            })
            .catch(error => {
                console.error(error);
            });
    }
}
