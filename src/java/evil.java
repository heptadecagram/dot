import java.lang.reflect.Field;

/**
 * Pulled from https://codegolf.stackexchange.com/questions/28786
 *
 * Answer from user12166
 */
public class Main {
    public static void main(String[] args) throws Exception {
        Class cache = Integer.class.getDeclaredClasses()[0];
        Field c = cache.getDeclaredField("cache");
        c.setAccessible(true);
        Integer[] array = (Integer[]) c.get(cache);
        array[132] = array[133];

        System.out.printf("%d",2 + 2);
    }
}
