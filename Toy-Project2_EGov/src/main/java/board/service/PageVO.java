package board.service;

public class PageVO {

	private int pageNum; /* 페이지 번호 */
	private int currentPrintBoardList; /* 한 페이지에 출력될 게시물 수 */
	private int currentPrintPage; /* 한 페이지에 출력될 페이지 수 */
	private int totalPage; /* 전체 페이지 수 */
	private int startPage; /* 시작 페이지 */
	private int endPage; /* 끝 페이지 */
	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
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
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
}
