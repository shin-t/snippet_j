package snippet

class Github {

    String access_token

    User user

    static constraints = {
        access_token blank: false, unique: true
    }
}
