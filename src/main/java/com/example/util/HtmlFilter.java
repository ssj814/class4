package com.example.util;

import org.apache.commons.text.StringEscapeUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
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
        System.out.println("Before decoding: " + input);
        
        // 1. HTML 디코딩
        String decodedInput = StringEscapeUtils.unescapeHtml4(input);
        System.out.println("After decoding: " + decodedInput);
        
        // 2. font-family 속성을 안전한 플레이스홀더로 변경
        String placeholderPrefix = "FONT_FAMILY_PLACEHOLDER_";
        String replacedInput = decodedInput.replaceAll(
            "font-family:\\s*\"([^\"]+)\"",
            "font-family:" + placeholderPrefix + "$1"
        );
        System.out.println("Replaced Input: " + replacedInput);
        
        // 3. 허용된 태그만 남기기 위한 Safelist 생성 (기본적으로 HTML 허용)
        Safelist safelist = Safelist.basicWithImages();
        
        safelist.addTags("table", "tr", "td", "th", "tbody", "thead", "tfoot", "caption", "span", "font");
        safelist.addAttributes("table", "border", "cellspacing", "cellpadding", "align");
        safelist.addAttributes("td", "colspan", "rowspan");
        safelist.addAttributes("th", "colspan", "rowspan");
        safelist.addAttributes("font", "color", "size", "face", "family");
        safelist.addAttributes("span", "style");
        safelist.addAttributes(":all", "style");

        // 4. Safelist.basicWithImages()로 필터링
        String safeOutput = Jsoup.clean(replacedInput, safelist);
        System.out.println("After Jsoup.clean: " + safeOutput);
        
        // 5. 플레이스홀더를 다시 복원
        String restoredHtml = safeOutput.replaceAll(
            "font-family:" + placeholderPrefix + "([^;]+)",
            "font-family: \'$1\'"
        );
        System.out.println("Restored Html: " + restoredHtml);
        
        return filterStyles(restoredHtml);
    }
    
    /**
    스타일 속성 필터링 로직
    @param html Safelist로 필터링된 HTML 문자열
    @return 추가 스타일 필터링이 적용된 HTML 문자열
    */
   private static String filterStyles(String html) {
       Document document = Jsoup.parse(html);

       // 모든 style 속성을 가진 태그를 탐색
       for (Element element : document.select("*[style]")) {
    	   String originalStyle = element.attr("style");
           String filteredStyle = filterStyleAttributes(originalStyle);
           element.attr("style", filteredStyle);
       }

       // 전체 HTML 구조를 유지하기 위해 outerHtml()을 사용
       return document.body().html(); 
   }

   /**
    허용된 스타일 속성만 남기는 메서드
    @param style style 속성 문자열
    @return 필터링된 style 속성 문자열
    */
   private static String filterStyleAttributes(String style) {
       StringBuilder filteredStyle = new StringBuilder();
       
       String[] allowedStyles = { "color", "font-size", "text-align", "font-family" };
       
       String[] styleAttributes = style.split(";");
       
       for (String attribute : styleAttributes) {
           attribute = attribute.trim();
           System.out.println("attribute : "+attribute.toString());
           // 허용된 스타일 속성만 추가
           for (String allowed : allowedStyles) {
               if (attribute.startsWith(allowed + ":")) {
                       filteredStyle.append(attribute).append("; ");
                   break;
               }
           }
       }

       return filteredStyle.toString().trim();
   }
   
}
