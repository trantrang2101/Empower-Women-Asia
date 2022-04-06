/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Tran Trang
 */
public class Blog {

    private int blogID;
    private String authorID, authorName, title, summary, content, image;
    boolean published;
    private String createdAt, updatedAt, publishedAt;
    private boolean react;

    public Blog() {
    }

    public Blog(int blogID, String authorID, String authorName, String title, String summary, String content, String image, String createdAt, String updatedAt, String publishedAt, boolean react) {
        this.blogID = blogID;
        this.authorID = authorID;
        this.authorName = authorName;
        this.title = title;
        this.summary = summary;
        this.content = content;
        this.image = image;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.publishedAt = publishedAt;
        this.react = react;
    }

    public boolean isPublished() {
        return published;
    }

    public void setPublished(boolean published) {
        this.published = published;
    }

    public Blog(int blogID, String authorID, String authorName, String title, String summary, String content, String image, boolean published, String createdAt, String updatedAt, String publishedAt, boolean react) {
        this.blogID = blogID;
        this.authorID = authorID;
        this.authorName = authorName;
        this.title = title;
        this.summary = summary;
        this.content = content;
        this.image = image;
        this.published = published;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.publishedAt = publishedAt;
        this.react = react;
    }

    public boolean isReact() {
        return react;
    }

    public void setReact(boolean react) {
        this.react = react;
    }

    public int getBlogID() {
        return blogID;
    }

    public void setBlogID(int blogID) {
        this.blogID = blogID;
    }

    public String getAuthorID() {
        return authorID;
    }

    public void setAuthorID(String authorID) {
        this.authorID = authorID;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getPublishedAt() {
        return publishedAt;
    }

    public void setPublishedAt(String publishedAt) {
        this.publishedAt = publishedAt;
    }

}
