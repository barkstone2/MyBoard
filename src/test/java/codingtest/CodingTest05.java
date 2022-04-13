package codingtest;

import org.junit.jupiter.api.Test;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 메뉴 리뉴얼
 */
public class CodingTest05 {

    @Test
    public void test() {
        solution(new String[]{"XYZ", "XWY", "WXA"}, new int[]{2,3,4});
    }

    private Map<String, Integer> combCountMap = new HashMap<>();

    public String[] solution(String[] orders, int[] course) {
        String[] answer = {};
        List<String> result = new ArrayList<>();

        for(String order : orders) {
            String[] arr = Arrays.stream(order.split("")).sorted().toArray(String[]::new);
            boolean[] visited = new boolean[arr.length];
            for(int r : course) {
                combination(arr, visited, 0, arr.length, r);
            }
        }

        for(int r: course) {
            List<String> keys = combCountMap.keySet().stream().filter(e -> e.length() == r).collect(Collectors.toList());

            int max = 0;
            for (String key : keys) {
                Integer count = combCountMap.get(key);
                if(count > max) max = count;
            }
            if(max > 1) {
                int finalMax = max;
                List<String> maxKeys = keys.stream().filter(e -> combCountMap.get(e) == finalMax).collect(Collectors.toList());
                result.addAll(maxKeys);
            }
        }

        answer = result.stream().sorted().toArray(String[]::new);
        return answer;
    }

    private void combination(String[] arr, boolean[] visited, int start, int n, int r) {
        if(r == 0) {
            putInMap(arr, visited, n);
            return;
        }

        for(int i=start; i<n; i++) {
            visited[i] = true;
            combination(arr, visited, i + 1, n, r - 1);
            visited[i] = false;
        }
    }

    private void putInMap(String[] arr, boolean[] visited, int n) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            if (visited[i]) {
                sb.append(arr[i]);
            }
        }
        combCountMap.put(sb.toString(), combCountMap.getOrDefault(sb.toString(), 0)+1);
    }

}
