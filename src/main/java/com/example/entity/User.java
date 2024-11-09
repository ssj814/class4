package com.example.entity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "users")
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int usernumber;

    @Column(unique = true)
    private String userid;

    private String userpw;
    private String realusername;
    private String emailusername;
    private String emaildomain;
    private String birthdate;
    private String gender;

    private int emailverified;
    private int termsagreed;

    private String phone1;
    private String phone2;
    private String phone3;

    private String postalcode;
    private String streetaddress;
    private String detailedaddress;
    private String nickname;
    private String profilepicture;
    private Integer mileage;
    private String socialprovider;
    private String ipaddress;
    private int isactive;

    private LocalDateTime created;
    private LocalDateTime updated;
    private LocalDateTime lastlogin;

    private String email;
    private String provider;
    private String providerid;

    @Enumerated(EnumType.STRING)
    private Role role;

    @Column(nullable = false)
    private String status; // 상태 필드 추가

    public enum Role {
        USER, ADMIN, TRAINER
    }

    public String getFormattedCreated() {
        return formatLocalDateTime(created);
    }

    public String getFormattedUpdated() {
        return formatLocalDateTime(updated);
    }

    public String getFormattedLastLogin() {
        return formatLocalDateTime(lastlogin);
    }

    private String formatLocalDateTime(LocalDateTime dateTime) {
        if (dateTime != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            return dateTime.format(formatter);
        }
        return "";
    }

    @PrePersist
    public void prePersist() {
        if (this.mileage == null) {
            this.mileage = 0;
        }
        if (this.role == null) {
            this.role = Role.USER;
        }
        if (this.status == null) {
            this.status = "ACTIVE"; // 기본 상태 설정
        }
        if (this.created == null) {
            this.created = LocalDateTime.now();
        }
        if (this.updated == null) {
            this.updated = LocalDateTime.now();
        }
        if (this.lastlogin == null) {
            this.lastlogin = LocalDateTime.now();
        }
    }
}
