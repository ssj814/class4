package com.example.util;

import com.example.badwordfiltering.BadWords;

public class BadWordFilter {

    // 게시글 내용에 금지어를 ***로 대체하는 메서드
	   public static String filterBadWords(String input) {
	        // 금지어를 ***로 대체
	        for (String badWord : BadWords.koreaWord1) {
	            input = input.replaceAll(badWord, "***");
	        }
	        return input;
	    }
}