import { LightningElement } from 'lwc';
import myResource from '@salesforce/resourceUrl/Audio';
import audio2 from '@salesforce/resourceUrl/ApKiTarifMe';
export default class AudioBook extends LightningElement {
audio = myResource + '/Kesariya.mp3';

audiotrack2 = audio2 + '/AapKiTarifMeKyaKahe.mp3';
playlist=[audio,audiotrack2];
playAudio(){
    let audio = new Audio();
    audio.src = this.audiotrack2;
    audio.load();
    // audio.autoplay = true;
    audio.play();
}
connectedCallback() {
    this.playAudio();
}
playList(event){
   this.playlist = this.audiotrack2;
   console.log('OUTPUT : ',event.currentTarget.value);
}
}