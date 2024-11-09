package com.example.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("FaqDTO")
public class FaqDTO {
	
	
	private int FAQ_QNA_ID;
	private String QUESTION;
	private String ANSWER;
	private String QUESTIONER;
	private Date FAQ_QNA_DATE;
	private String CATEGORY;
	
	
	public FaqDTO() {
		super();
		
	}





	public int getFAQ_QNA_ID() {
		return FAQ_QNA_ID;
	}


	public void setFAQ_QNA_ID(int fAQ_QNA_ID) {
		FAQ_QNA_ID = fAQ_QNA_ID;
	}


	public String getQUESTION() {
		return QUESTION;
	}


	public void setQUESTION(String qUESTION) {
		QUESTION = qUESTION;
	}


	public String getANSWER() {
		return ANSWER;
	}


	public void setANSWER(String aNSWER) {
		ANSWER = aNSWER;
	}


	public String getQUESTIONER() {
		return QUESTIONER;
	}


	public void setQUESTIONER(String qUESTIONER) {
		QUESTIONER = qUESTIONER;
	}


	public Date getFAQ_QNA_DATE() {
		return FAQ_QNA_DATE;
	}


	public void setFAQ_QNA_DATE(Date fAQ_QNA_DATE) {
		FAQ_QNA_DATE = fAQ_QNA_DATE;
	}


	public String getCATEGORY() {
		return CATEGORY;
	}


	public void setCATEGORY(String cATEGORY) {
		CATEGORY = cATEGORY;
	}
	
	
	
	public FaqDTO(int fAQ_QNA_ID, String qUESTION, String aNSWER, String qUESTIONER, Date fAQ_QNA_DATE,
			String cATEGORY) {
		super();
		FAQ_QNA_ID = fAQ_QNA_ID;
		QUESTION = qUESTION;
		ANSWER = aNSWER;
		QUESTIONER = qUESTIONER;
		FAQ_QNA_DATE = fAQ_QNA_DATE;
		CATEGORY = cATEGORY;
	}


	@Override
	public String toString() {
		return "FaqDTO [FAQ_QNA_ID=" + FAQ_QNA_ID + ", QUESTION=" + QUESTION + ", ANSWER=" + ANSWER + ", QUESTIONER="
				+ QUESTIONER + ", FAQ_QNA_DATE=" + FAQ_QNA_DATE + ", CATEGORY=" + CATEGORY + "]";
	}
	
	
	
	

}
