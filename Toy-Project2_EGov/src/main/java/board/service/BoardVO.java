package board.service;

import java.util.Date;

public class BoardVO {

	// 게시글
	private int idx;
	private String title;
	private String content;
	private String id;
	private String anony;
	private int hits;
	private Date rdate;
	private Date modifyDt;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	public Date getModifyDt() {
		return modifyDt;
	}
	public void setModifyDt(Date modifyDt) {
		this.modifyDt = modifyDt;
	}
	
	// 파일
	private int fileNo;
	private String filePath;
	private String fileOrigin;
	private String fileEncry;
	private String fileSize;
	private String fileExten;
	private Date createDt;
	private int boardIdx;
	
	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileOrigin() {
		return fileOrigin;
	}
	public void setFileOrigin(String fileOrigin) {
		this.fileOrigin = fileOrigin;
	}
	public String getFileEncry() {
		return fileEncry;
	}
	public void setFileEncry(String fileEncry) {
		this.fileEncry = fileEncry;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileExten() {
		return fileExten;
	}
	public void setFileExten(String fileExten) {
		this.fileExten = fileExten;
	}
	public Date getCreateDt() {
		return createDt;
	}
	public void setCreateDt(Date createDt) {
		this.createDt = createDt;
	}
	public int getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}
}
