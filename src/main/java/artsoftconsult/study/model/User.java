package artsoftconsult.study.model;

import org.hibernate.annotations.DynamicInsert;
import org.springframework.stereotype.Component;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Collection;

/**
 * Created by viorelv on 7/14/2017.
 */
@Component
@Entity
@DynamicInsert
@Table(name = "users", schema = "forum")
public class User {
    private Integer userId;
    private String username;
    private String password;
    private String password2;
    private String firstName;
    private String lastName;
    private String email;
    private Date dateOfBirth;
    private String gender;
    private String role = "ROLE_USER";
    private Timestamp creationDate = new Timestamp(new java.util.Date().getTime());
    private Byte enabled = 0;
    private String profileImage = "/profileImage/generic.png";
    private Boolean isAdmin;
    private Collection<HibernateUti> utisByUserId;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "userID", nullable = false)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "username", nullable = false, length = 50)
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Basic
    @Column(name = "password", nullable = false, length = 60)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Transient
    public String getPassword2() {
        return password2;
    }

    public void setPassword2(String password2) {
        this.password2 = password2;
    }

    @Basic
    @Column(name = "firstName", nullable = true, length = 50)
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    @Basic
    @Column(name = "lastName", nullable = true, length = 50)
    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    @Basic
    @Column(name = "email", nullable = false, length = 50)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "dateOfBirth", nullable = true)
    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    @Basic
    @Column(name = "gender", nullable = true, length = 50)
    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @Basic
    @Column(name = "role", nullable = false, length = 50)
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Basic
    @Column(name = "creationDate", nullable = false)
    public Timestamp getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Timestamp creationDate) {
        this.creationDate = creationDate;
    }

    @Basic
    @Column(name = "enabled", nullable = false)
    public Byte getEnabled() {
        return enabled;
    }

    public void setEnabled(Byte enabled) {
        this.enabled = enabled;
    }

    @Basic
    @Column(name = "profileImage", nullable = false, length = 50)
    public String getProfileImage() {
        return profileImage;
    }

    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        User that = (User) o;

        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;
        if (username != null ? !username.equals(that.username) : that.username != null) return false;
        if (password != null ? !password.equals(that.password) : that.password != null) return false;
        if (firstName != null ? !firstName.equals(that.firstName) : that.firstName != null) return false;
        if (lastName != null ? !lastName.equals(that.lastName) : that.lastName != null) return false;
        if (email != null ? !email.equals(that.email) : that.email != null) return false;
        if (dateOfBirth != null ? !dateOfBirth.equals(that.dateOfBirth) : that.dateOfBirth != null) return false;
        if (gender != null ? !gender.equals(that.gender) : that.gender != null) return false;
        if (role != null ? !role.equals(that.role) : that.role != null) return false;
        if (creationDate != null ? !creationDate.equals(that.creationDate) : that.creationDate != null) return false;
        if (enabled != null ? !enabled.equals(that.enabled) : that.enabled != null) return false;
        if (profileImage != null ? !profileImage.equals(that.profileImage) : that.profileImage != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = userId != null ? userId.hashCode() : 0;
        result = 31 * result + (username != null ? username.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (firstName != null ? firstName.hashCode() : 0);
        result = 31 * result + (lastName != null ? lastName.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (dateOfBirth != null ? dateOfBirth.hashCode() : 0);
        result = 31 * result + (gender != null ? gender.hashCode() : 0);
        result = 31 * result + (role != null ? role.hashCode() : 0);
        result = 31 * result + (creationDate != null ? creationDate.hashCode() : 0);
        result = 31 * result + (enabled != null ? enabled.hashCode() : 0);
        result = 31 * result + (profileImage != null ? profileImage.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", password2='" + password2 + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", email='" + email + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                ", gender='" + gender + '\'' +
                ", role='" + role + '\'' +
                ", creationDate=" + creationDate +
                ", enabled=" + enabled +
                ", profileImage='" + profileImage + '\'' +
                ", isAdmin=" + isAdmin +
                '}';
    }

    //shame to the family
    @Transient
    public String getUsernameForUpdate() {
        if (username.equals(""))
            return null;
        return username;
    }

    @Transient
    public String getPasswordForUpdate() {
        if (password.equals(""))
            return null;
        return password;
    }

    @Transient
    public String getPassword2ForUpdate() {
        if (password2.equals(""))
            return null;
        return password2;
    }

    @Transient
    public String getFirstNameForUpdate() {
        if (firstName.equals(""))
            return null;
        return firstName;
    }

    @Transient
    public String getLastNameForUpdate() {
        if (lastName.equals(""))
            return null;
        return lastName;
    }

    @Transient
    public String getEmailForUpdate() {
        if (email.equals(""))
            return null;
        return email;
    }

    @Transient
    public Date getDateOfBirthForUpdate() {
        if (dateOfBirth == null)
            return Date.valueOf("1970-01-01");
        return dateOfBirth;
    }

    @Transient
    public String getProfileImageForUpdate() {
        if (profileImage.equals(""))
            return null;
        return profileImage;
    }


    @Transient
    public Boolean getAdmin() {
        return isAdmin;
    }

    public void setAdmin(Boolean admin) {
        isAdmin = admin;
    }

    @OneToMany(mappedBy = "user")
    public Collection<HibernateUti> getUtisByUserId() {
        return utisByUserId;
    }

    public void setUtisByUserId(Collection<HibernateUti> utisByUserId) {
        this.utisByUserId = utisByUserId;
    }
}
