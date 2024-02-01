package board.service;

import java.util.Date;

public class BoardVO {

	private String title;
	private String content;
	private String anony;
	private int hits;
	private String userId;
	private Date rdate;
	private int idx;
	private String keyword;
	private String gubun;
	private int currentPrintBoardList; /* 한 페이지에 출력될 게시물 수 */
	private int currentPrintPage; /* 한 페이지에 출력될 페이지 수 */
	private int pageNum; /* 페이지 번호 */
	private boolean isPrev;
	private boolean isNext;

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAnony() {
		return anony;
	}
	public void setAnony(String anony) {
		this.anony = anony;
	}
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public int getCurrentPrintBoardList() {
		return currentPrintBoardList;
	}
	public void setCurrentPrintBoardList(int currentPrintBoardList) {
		this.currentPrintBoardList = currentPrintBoardList;
	}
	public int getCurrentPrintPage() {
		return currentPrintPage;
	}
	public void setCurrentPrintPage(int currentPrintPage) {
		this.currentPrintPage = currentPrintPage;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public boolean isPrev() {
		return isPrev;
	}
	public void setPrev(boolean isPrev) {
		this.isPrev = isPrev;
	}
	public boolean isNext() {
		return isNext;
	}
	public void setNext(boolean isNext) {
		this.isNext = isNext;
	}
}
