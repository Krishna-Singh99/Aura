public class color {
    public  color()
    {
        list<string> col=new List<String>{'Red','Yellow'};
            col.add('Black');
            system.debug(col);
        string[] col2= new List<String>();
        col2.add('Red');
        string cmp1 = col2.get(0);
        string cmp2 = col2[0];
      system.assertEquals(cmp1,cmp2);
        List<String> reversed = new List<String>();
        for(Integer i = col.size() - 1; i >= 0; i--)
        {
           reversed.add(col[i]);
            system.debug(reversed);
        }
    }
}