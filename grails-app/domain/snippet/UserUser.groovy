package snippet

import auth.*

class UserUser implements Serializable {

    static belongsTo = [follower:User, user:User]
    static mapping = {
        id composite:['follower', 'user']
        version false
    }
    static constraints = {
    }

    static UserUser get(long followerId, long userId) {
        find 'from UserUser where follower.id=:followerId and user.id=:userId',
            [followerId: followerId, userId: userId]
    }

    static UserUser create(User follower, User user, boolean flush = false) {
        def instance = new UserUser(follower: follower, user: user).save(flush: flush, insert: true)
        return instance
    }

    static boolean remove(User follower, User user, boolean flush = false) {
        UserUser instance = UserUser.findByFollowerAndUser(follower, user)
        instance ? instance.delete(flush: flush) : false
    }
}
