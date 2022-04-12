package codingtest;

import org.junit.jupiter.api.Test;
import java.util.HashSet;
import java.util.Set;

/**
 * 영어 끝말잇기
 */
public class CodingTest04 {

    @Test
    public void test() {

    }

    public int[] solution(int n, String[] words) {
        int[] answer = new int[2];

        Set<String> set = new HashSet<>();

        int lap = 1;
        int turn = 1;

        String lastAlphabet = "";

        for(String word : words) {

            if(set.contains(word) || !word.startsWith(lastAlphabet)) {
                answer[0] = turn;
                answer[1] = lap;
                break;
            } else {
               set.add(word);
               lastAlphabet = String.valueOf(word.charAt(word.length() - 1));
            }

            if(turn == n) {
                lap++;
                turn = 1;
            } else {
                turn++;
            }
        }

        return answer;
    }
}
