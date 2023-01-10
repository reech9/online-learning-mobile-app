const List<Map<String, dynamic>> dummyProduct = [
  {
    "title": "Learn Python: The Complete Python Programming Course",
    "user": "The Codex, Avinash Jain",
    "image": "assets/demo/course/course1.jpg",
    "rating": 3.4,
    "price": 100,
    "discount": 10,
    "progress": 10,
  },
  {
    "title": "Learning Python for Data Analysis and Visualization",
    "user": "Jose Portilla",
    "image": "assets/demo/course/course2.jpg",
    "rating": 1.4,
    "price": 200,
    "discount": 0,
    "progress": 20,
  },
  {
    "title": "Python for Beginners - Learn Programming from scratch",
    "user": "Edwin Diaz, Coding Faculty Solutions",
    "image": "assets/demo/course/course3.jpg",
    "rating": 2.3,
    "price": 300,
    "discount": 20,
    "progress": 0,
  },
  {
    "title": "1 Hour JavaScript",
    "user": "John Dura",
    "image": "assets/demo/course/course4.jpg",
    "rating": 3.2,
    "price": 400,
    "discount": 100,
    "progress": 100,
  },
  {
    "title": "JavaScript for Kids: Code Your Own Games and Apps at Any Age",
    "user": "Bryson Payne",
    "image": "assets/demo/course/course5.jpg",
    "rating": 5.0,
    "price": 100,
    "discount": 30,
    "progress": 60,
  },
  {
    "title": "ES6 Javascript: The Complete Developer's Guide",
    "user": "Stephen Grider",
    "image": "assets/demo/course/course6.jpg",
    "rating": 4.2,
    "price": 120,
    "discount": 10,
    "progress": 50,
  },
  {
    "title": "Microsoft Excel 2013  Advanced. Online Excel Training Course",
    "user": "Infinite Skills",
    "image": "assets/demo/course/course7.jpg",
    "rating": 3.6,
    "price": 1000,
    "discount": 300,
    "progress": 2,
  },
  {
    "title": "7 Steps To Excel Success - Excel Skills And Power Tips",
    "user": "Billy Wigley, Stephanie Jhoy Tumulak",
    "image": "assets/demo/course/course8.jpg",
    "rating": 3.5,
    "price": 100,
    "discount": 30,
    "progress": 70,
  },
];

const List<Map<String, dynamic>> dummyNotification = [
  {
    "title":
        """How can I implement lazy loading with Staggered Grid View in Flutter. https://pub.dev/packages/flutter_staggered_grid_view is not working well by list of images. GridView.builder is working well and GridView is loading more images when scroll reaches to bottom but unfortunately flutter_staggered_grid_view is not.""",
    "date": "02 Nov",
    "image": "assets/demo/course/course1.jpg",
    "seen": false
  },
  {
    "title":
    """We have made some changes to the privacy settings. To review and change your settings, please go to your profile.""",
    "date": "23 Mar",
    "image": "assets/demo/course/course3.jpg",
    "seen": true
  },
  {
    "title":
    """ FutureLearn would like to know what motivated you to join Building a Future with Robots.""",
    "date": "23 Mar",
    "image": "assets/demo/course/course3.jpg",
    "seen": false
  },{
    "title":
    """ FutureLearn would like to know what motivated you to join Building a Future with Robots.""",
    "date": "23 Mar",
    "image": "assets/demo/course/course3.jpg",
    "seen": true
  },{
    "title":
    """ FutureLearn would like to know what motivated you to join Building a Future with Robots.""",
    "date": "23 Mar",
    "image": "assets/demo/course/course3.jpg",
    "seen": false
  },
];
// String image = "";
// String title = "";
// String subTitle = "";
// num students = 0;
// num courses = 0;
const Map<String, dynamic> demoInstrcutor = {
  "title": "Dr. Test Lorem ipsum | AWS Certified, Cloud Computing",
  "subTitle":
      """Maecenas a euismod tellus, quis aliquam dolor. Etiam nisl odio, vulputate vel metus quis, luctus dictum ligula. Suspendisse potenti. """,
  "image": "assets/demo/user/user1.jpg",
  "students": 100000,
  "courses": 500,
  "reviews": 8000,
  "description": """
     Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam dapibus commodo placerat. Pellentesque fermentum nisl sit amet nisi porttitor luctus. Phasellus faucibus rutrum aliquet. Praesent iaculis massa felis, ut ultrices elit faucibus sed. Cras at dapibus nibh. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Praesent vulputate urna in enim ultricies, non iaculis ante euismod. Pellentesque dapibus mollis purus, eget vestibulum lacus elementum vestibulum. Etiam a egestas nulla. Phasellus at aliquet enim, ut tincidunt eros. Donec in nunc ut justo convallis accumsan at et dolor. Phasellus ac varius enim, vitae ultrices magna. Nunc ut sagittis purus. Morbi lectus tortor, mattis in ex sagittis, vehicula consequat mauris.

Sed vel facilisis turpis. Duis eu metus rutrum, porta leo a, elementum lorem. Aenean sit amet suscipit justo, id egestas nunc. Aliquam nec laoreet eros. Maecenas vehicula ullamcorper laoreet. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut pretium nisi nec blandit mattis. Fusce bibendum augue lectus, in bibendum arcu auctor at. Praesent id maximus justo, eget tempor purus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut iaculis eu ante ut dictum. Integer pellentesque quam at est luctus, id bibendum ante hendrerit. Fusce consectetur dignissim lacinia.

Maecenas a euismod tellus, quis aliquam dolor. Etiam nisl odio, vulputate vel metus quis, luctus dictum ligula. Suspendisse potenti. Phasellus ornare eleifend neque, id consequat ligula sodales ac. Quisque bibendum pellentesque mi non pellentesque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi maximus dui dolor, vitae faucibus felis luctus quis. In eleifend sapien eget luctus lobortis. Maecenas quam arcu, pharetra sit amet risus vel, rutrum condimentum massa. Vestibulum ac ultricies sem. Morbi pulvinar, leo non elementum convallis, augue ex interdum tortor, sed commodo ligula libero sit amet leo. Vivamus dapibus libero lacus. Proin id elit varius, imperdiet nibh vel, mollis metus. Sed fermentum commodo orci, in fringilla tortor suscipit vitae.

Sed dolor diam, hendrerit eget nisi et, iaculis dictum ante. In non dapibus metus, non pulvinar ipsum. Suspendisse facilisis diam non mi malesuada mattis. Nullam sollicitudin purus vel lorem laoreet faucibus. Phasellus non ante augue. Aliquam nec tortor est. Aenean molestie malesuada egestas. Vestibulum ac consectetur augue, id molestie justo. Nullam condimentum at nulla a suscipit. Vivamus blandit risus in congue suscipit. Cras mattis, justo non commodo congue, eros sapien pretium lorem, sit amet faucibus lectus felis ac magna. Etiam porttitor odio enim, quis ornare lacus iaculis ut. Sed at libero vehicula, fermentum turpis ac, euismod augue. 
    """
};

const List<Map<String, dynamic>> dummyInstructor = [
  {
    "title": "Dr. Test Lorem ipsum",
    "subTitle": "User 1",
    "image": "assets/demo/user/user1.jpg",
    "students": 100000,
    "courses": 500
  },
  {
    "title": "Dr. Minux Tow Three Test Lorem ipsum",
    "subTitle": "User 2",
    "image": "assets/demo/user/user2.jpg",
    "students": 700000,
    "courses": 700
  },
  {
    "title": "Sr. Test Lorem ipsum ",
    "subTitle": "User 3",
    "image": "assets/demo/user/user3.jpg",
    "students": 90000,
    "courses": 5000
  },
  {
    "title": "Mrs. Test Lorem ipsum",
    "subTitle": "User 4",
    "image": "assets/demo/user/user4.jpg",
    "students": 900000,
    "courses": 600
  },
  {
    "title": "Mr. Test Lorem ipsum",
    "subTitle": "User 5",
    "image": "assets/demo/user/user5.jpg",
    "students": 80000,
    "courses": 100
  },
  {
    "title": "Mr. Test Lorem ipsum",
    "subTitle": "User 6",
    "image": "assets/demo/user/user6.jpg",
    "students": 866000,
    "courses": 1000
  },
];
const List<String> dummyCategories = [
  "Science",
  "Maths",
  "Computer",
  "Law",
  "English",
  "Physics",
  "Python",
  "Javascript",
  "Mongo",
  "SQL",
  "Oracle"
];
