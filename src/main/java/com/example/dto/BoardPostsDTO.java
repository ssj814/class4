package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("BoardPostsDTO")
public class BoardPostsDTO {
	private int postId;          // 게시글 번호
    private int categoryId;      // 게시판 카테고리 ID
    private String title;        // 글 제목
    private String content;      // 글 내용
    private String writer;       // 작성자
    private int viewCount;       // 조회수
    private String imageName;    // 이미지 이름
    private String createdAt;    // 작성 일자
    private String updatedAt;    // 수정 일자
	private String popup;        // 팝업 여부 (Y/N)
	private String realName; // 작성자의 실명
}
