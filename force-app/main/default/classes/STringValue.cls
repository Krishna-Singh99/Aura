public class STringValue {
    public static List<String> gTringArray(Integer n){
        List<String> myArray = new List<String>();
        for(Integer i=0;i<n;i++){
            myArray.add('Test'+i);
            system.debug(myArray[i]);
        }
        return myArray;
    }
}