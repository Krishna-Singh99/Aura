public class DiffrenceInDate {
    public static void diffrence(){
        DateTime startDate= DateTime.newInstance(2016, 1, 2, 6, 5, 55);
        DateTime endDate= DateTime.newInstance(2016, 2, 5 , 7 , 8 , 55);
        decimal diffDay = ((Math.abs((startDate.getTime()-endDate.getTime())/(1000*60)))/60)/24;
        decimal diffHour = diffDay * 24;
        decimal diffMin = diffHour * 60;
        decimal diffSec = diffMin * 60;
        Integer diffMon =Integer.valueOf( diffDay / 30);
        decimal diffYear = diffMon / 12;
        
  system.debug(diffYear + ' Year ' + diffMon +  ' Month ' +  diffDay + ' Day ' + diffHour + ' Hour '+ diffMin + ' Minute '+ diffSec + ' Second');
    
    }
}