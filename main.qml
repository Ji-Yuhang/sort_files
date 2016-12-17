import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import an.qt.FileHelper 1.0
ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Sort files")

    FileHelper {
      id: helper
    }

    Component.onCompleted: {
        var path = "file:///Users/jiyuhang/Desktop/冀文心排序后/"
        var files = helper.get_all_files("/Users/jiyuhang/Desktop/冀文心排序后/")
        var md5s = helper.get_all_files_md5s("/Users/jiyuhang/Desktop/冀文心排序后/")
        //console.log("get_all_files: ", files)
        console.log("get_all_files_md5s: ", md5s)

        for(var i = 0; i < md5s.length; i++) {
          var md5 = md5s[i]
          var path_file = helper.file_path_by_md5(md5)
          var data = {
            image: "file://" + path_file,
            md5: md5
          }

          model.append(data)
        }


    }

    ListModel {
        id: model

    }
    ListModel {
        id: sort_model
    }

    Component {
        id: delegate
        Rectangle {
          id: wrapper
          width: 100
          height: 100
          MouseArea {
            anchors.fill: parent
            onClicked: {
              wrapper.ListView.view.currentIndex = index
              console.log("onClicked", index)
            }
          }
          Column{
            anchors.fill: parent
              
            Image {
              id: delegate_image
              width: 100
              height: 100
              source: image || '空图片'
            }
            Column {
                Text{
                    id: delegate_text
                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    //anchors.left : delegate_image.anchors.right
                    width: 50
                    height: 20
                    text: md5
                    
                    elide:Text.ElideRight
                }
                Text{
                    id: delegate_index

                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    //anchors.left : delegate_image.anchors.right
                    width: 50
                    height: 20
                    text: "第 " +  index
                }
            }
          }
        }
    }
 Component {
        id: delegate2

        Rectangle {
          id: wrapper
          width: 100
          height: 100
          MouseArea {
            anchors.fill: parent
            onClicked: {
              wrapper.GridView.view.currentIndex = index
              console.log("onClicked", index)
            }
          }
          Column{
            anchors.fill: parent
              
            Image {
              id: delegate_image
              //anchors.centerIn: parent
              width: 60
              height: 60
              source: image || '空图片'
            }
            //Column {
              //anchors.top: delegate_image.bottom
                Text{
                    id: delegate_text
                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    //anchors.left : delegate_image.anchors.right
                    width: 50
                    height: 10
                    text: md5
                    
                    elide:Text.ElideRight
                }
                Text{
                    id: delegate_index

                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    //anchors.left : delegate_image.anchors.right
                    width: 50
                    height: 10
                    text: "第 " +  index
                }
            //}
          }
        }
    }
    //Column {
      //height: 400
      //anchors.fill: parent
      ListView {
        id: view
        width: parent.width
        height: 140
        model: model
        delegate: delegate
        orientation: ListView.Horizontal 
        z: 2

        spacing: 2
        focus: true
        Keys.enabled: true
        Keys.onPressed: {
          console.log("key press", event.key)
          var data = model.get(view.currentIndex)
          //console.log("currentIndex data:", JSON.stringify(data), JSON.stringify(data["0"]))
          switch (event.key) {
            case Qt.Key_Up:

            break;

            case Qt.Key_Down:
           var data2 = {
              image: data.image,
              md5: data.md5
              //image: "file:///Users/jiyuhang/Desktop/冀文心排序后/IMG_0237_2.jpg",
              //md5: "423d46995a9067841c371317b9834c7f"
            }
            sort_model.append(data)
            model.remove(currentIndex,1)
            sort_view.currentIndex = sort_model.count - 1

            break;

            case Qt.Key_Right:
            view.currentIndex = view.currentIndex + 1 
            break;

            case Qt.Key_Left:
            view.currentIndex = view.currentIndex - 1 < 0 ? 0 : view.currentIndex - 1
            break;

            default:
            break;


          }
          event.accepted = true
        }
      }
      Slider{
        id:control
        anchors.top: view.bottom
        focus: false
        height: 20
        width: parent.width
        orientation: Qt.Horizontal 
        value: view.currentIndex
        stepSize: 1
        from: 0
        to: model.count
        handle: Rectangle {
          id: handle
          x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
          y: control.topPadding + control.availableHeight / 2 - height / 2
          implicitWidth: 26
          implicitHeight: 26
          radius: 13
          color: control.pressed ? "#f0f0f0" : "#f6f6f6"
          border.color: "#bdbebf"
          Text {
            anchors.centerIn: handle
            text: view.currentIndex + " / " + model.count
          }
        }
      }

      GridView {
        id: sort_view
        width:parent.width
        anchors.top: control.bottom
        height: 400
        model: sort_model
        delegate: delegate2
        focus: true

        //orientation: ListView.Horizontal 
        z: 1
        //spacing: 2

      }
    //}




//    SwipeView {
//        id: swipeView
//        anchors.fill: parent
//        currentIndex: tabBar.currentIndex

//        Page1 {
//        }

//        Page {
//            Label {
//                text: qsTr("Second page")
//                anchors.centerIn: parent
//            }
//        }
//    }

//    footer: TabBar {
//        id: tabBar
//        currentIndex: swipeView.currentIndex
//        TabButton {
//            text: qsTr("First")
//        }
//        TabButton {
//            text: qsTr("Second")
//        }
//    }
}
