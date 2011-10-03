package snippet

import auth.*

class UserTag implements Serializable {

    static belongsTo = [follower:User, tag:Tag]
    static mapping = {
        id composite:['follower', 'tag']
        version false
    }
    static constraints = {
    }

    static UserTag get(long followerId, String tagName) {
        find 'from  UserTag where follower.id=:followerId and tag.name=:tagName',
            [followerId: followerId, tagName: tagName]
    }

    static UserTag create(User follower, Tag tag, boolean flush = false) {
        def instance = new UserTag(follower: follower, tag: tag).save(flush: flush, insert: true)
        return instance
    }

    static boolean remove(User follower, Tag tag, boolean flush = false) {
        UserTag instance = UserTag.findByFollowerAndTag(follower, Tag)
        instance ? instance.delete(flush: flush) : false
    }
}
