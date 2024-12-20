package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("SearchResultDTO")
public class SearchResultDTO {
    private String category; 	// 카테고리 (PRODUCT, FAQ, BOARD)
    private String title;    	// 제목
    private String content;  	// 내용
    private String writer;     	// 작성자
    private String createdAt;  	// 생성일자
    private int productPrice;
    private int id;
}
