package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("TrainerBoardCommentDTO")
public class TrainerBoardCommentDTO {

//TrainerBoardCommentDTO 수정 10.29
	
	private int postId; //글고유번호
	private int commId; //댓글고유번호
	private int userId; //댓글작성자
	private String commContent; //댓글내용
	private String comCrdate; //댓글작성일
	private String comUpdate; //댓글수정일
	private Integer parentId = 0; //부모댓글
	private int repIndent; //댓글들여쓰기기준
	
	
	
}
