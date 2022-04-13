package codingtest;

import org.junit.jupiter.api.Test;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * [1차] 캐시
 * LRU(Least Recently Used) 알고리즘을 적용하기 위해 Map을 사용 했는데
 * Queue를 사용해 캐시된 값을 사용할 경우 제거 후 마지막에 추가하는 방법이 더 좋아보인다.
 */
public class CodingTest06 {

    @Test
    public void test() {
        //solution(2, new String[]{"Jeju", "Pangyo", "NewYork", "newyork"});
//        solution2(0, new String[]{"Jeju", "Pangyo", "Seoul", "NewYork", "LA"});

    }

    /**
     * Map을 이용한 방법
     */
    public int solution(int cacheSize, String[] cities) {
        int answer = 0;
        Map<String, Integer> cacheMap = new ConcurrentHashMap<>();

        for (String city : cities) {
            city = city.toLowerCase(Locale.ROOT);
            for (String s : cacheMap.keySet()) cacheMap.put(s, cacheMap.getOrDefault(s, 0)+1);

            if(cacheMap.containsKey(city)) {
                answer++;
                cacheMap.put(city, 1);
            } else if(cacheMap.size() < cacheSize){
                cacheMap.put(city, 1);
                answer += 5;
            } else {
                Optional<Integer> oldest = cacheMap.values().stream().max(Integer::compareTo);
                for (String key : cacheMap.keySet()) {
                    if(cacheMap.get(key) == oldest.get()) {
                        cacheMap.remove(key);
                        cacheMap.put(city, 1);
                    }
                }
                answer += 5;
            }
        }
        return answer;
    }

    /**
     * Queue를 이용한 방법
     */
    public int solution2(int cacheSize, String[] cities) {
        int answer = 0;
        Queue<String> cache = new LinkedList<>();

        if(cacheSize == 0) return 5 * cities.length;
        for (String city : cities) {
            city = city.toLowerCase(Locale.ROOT);

            if(cache.contains(city)) {
                answer++;
                cache.remove(city);
            } else {
                answer += 5;
                if (cache.size() == cacheSize) cache.poll();
            }

            cache.offer(city);
        }
        return answer;
    }

}
