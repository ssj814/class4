package com.example.util;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.safety.Safelist;

public class HtmlFilter {

    /**
      HTML 태그 필터링 메서드
      @param input HTML 문자열
      @return 필터링된 안전한 HTML 문자열
    */
    public static String filterHtml(String input) {
        if (input == null || input.isEmpty()) {
            return "";
        }

        // 허용된 태그만 남기기 위한 Safelist 생성 (기본적으로 HTML 허용)
        Safelist safelist = Safelist.basicWithImages();

        // 필요에 따라 추가적인 태그 및 속성을 허용
        safelist.addAttributes(":all", "style");
        safelist.addAttributes("a", "target", "href", "rel");
        
        Document dirty = Jsoup.parse(input);
        String clean = Jsoup.clean(input, safelist);
        System.out.println("Filtered Content: " + clean.toString());

        // 입력 HTML을 클린 필터링
        return Jsoup.clean(input, safelist);
    }
}
