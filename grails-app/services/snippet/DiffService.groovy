package snippet

class DiffService {

    static transactional = false

    def getV_Status(v_minus, v_plus){
        if((!v_minus)&&(!v_plus)) return 0

        if(!v_minus) return 1

        if(!v_plus) return 2

        if(v_minus.x < v_plus.x){
            return 1
        }
        else{
            return 2
        }
    }

    def getEndPoint(strl1,strl2) {
        def v = []
        def offset = strl2.size()+1

        for(def d = 0; d <= (strl1.size()+strl2.size()); d++) {
            def kmax = d<=strl1.size()?d:(strl1.size()-(d-strl1.size()))
            def kmin = d<=strl2.size()?d:(strl2.size()-(d-strl2.size()))

            for(def k=-kmin;k<=kmax;k+=2){
                def index=offset+k
                def x,y,parent

                switch(getV_Status(v[index-1],v[index+1])){
                    case 0:
                        x=y=0
                        parent=[x:0,y:0,parent:null]
                        break
                    case 1:
                        x=v[index+1].x
                        y=v[index+1].y+1
                        parent=v[index+1]
                        break
                    case 2:
                        x=v[index-1].x+1
                        y=v[index-1].y
                        parent=v[index-1]
                        break
                }

                while((x < strl1.size())&&(y < strl2.size())&&(strl1[x]==strl2[y])){
                    x++
                    y++
                }

                v[index]=[x:x,y:y,parent:parent]

                println v

                if((strl1.size() <= x)&&(strl2.size() <= y))return v[index]
            }
        }
    }

    def getDiffString(strl1, strl2){
        println "aaa"
        def point=getEndPoint(strl1,strl2)
        println "point:${point}"
        def diff_string=""
        while(point.parent!=null){
            def parent=point.parent
            def dx=point.x-parent.x
            def dy=point.y-parent.y
            def same_len=(dx<dy)?dx:dy

            for(def i =0; i < same_len; i++){
                diff_string="  ${strl1[point.x-i-1]}\n"+diff_string
            }

            if(dy<dx){
                diff_string="- ${strl1[parent.x]}\n"+diff_string
            }else if(dx<dy){
                diff_string="+ ${strl2[parent.y]}\n"+diff_string
            }

            point=parent
        }
        println "--\ndiff_string\n${diff_string}\n--"
        return diff_string
    }

}
