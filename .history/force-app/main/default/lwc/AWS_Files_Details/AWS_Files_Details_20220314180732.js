import { LightningElement, track, wire, api } from 'lwc';
import awsjssdk  from '@salesforce/resourceUrl/awsjssdk';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
import getFileUrl from '@salesforce/apex/S3FileController.AWS_Request';

export default class viewFile extends LightningElement {
    @api recordId;
    @track url;
    imageUrl;
    renderedCallback() {
        Promise.all([
                loadScript(this, awsjssdk),
            ])
            .then(() => {
                console.log('Files loaded.');
            })
            .catch(error => {
                console.log(error.body.message);
            });
    }

    @wire(getFileUrl, {recid: '$recordId'})
    wiredDocs({data,error}) {
        if (data) {
            if (data != undefined) {
                this.url = data[0].toString();
            }
            this.error = undefined;
            this.showDocument();
        } else if (error) {
            this.error = error;
            this.url = undefined;
        }
    }

    async showDocument() {

        const AWS = window.AWS;
        AWS.config.update({
            accessKeyId: "your acess key",
            secretAccessKey: "your secret key",
            region_config: "eu-west-2"
        });
     
        var s3 = new AWS.S3();
        var strImageUrl = this.url;
        if (strImageUrl != null && strImageUrl != '') {
            var keyindex = strImageUrl.lastIndexOf("/");
            var strKey = strImageUrl.substring(keyindex + 1);
            var bcktindex = strImageUrl.indexOf("amazonaws.com/") + 14;
            var strBucket = strImageUrl.substring(bcktindex, keyindex);
        }
        
        async function getSignedUrl(key) {
            return new Promise((resolve, reject) => {
                let params = {
                    Bucket: strBucket,
                    Key: strKey
                };
                s3.getSignedUrl('getObject', params, (err, url) => {
                    if (err) reject(err)
                    resolve(url);
                })
            });
        }

        async function processFiles(items) {
            for (let item of items) {
                const signedUrl = await getSignedUrl(item.fileName);
                item.url = signedUrl;
            }
            return items;
        }

        //Create array if multiple file
        let files = [
            {
                fileName: strImageUrl
            }
        ];

        processFiles(files).then(res => {
            //res is array. So if you are passing multiple file then assign values based on array 
            this.imageUrl = res[0].url
        });
    }
}