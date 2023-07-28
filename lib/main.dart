import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ipssi2023montevrain/controller/animation_controller.dart';
import 'package:ipssi2023montevrain/controller/background_controller.dart';
import 'package:ipssi2023montevrain/controller/firestore_helper.dart';
import 'package:ipssi2023montevrain/controller/permission_photo.dart';
import 'package:ipssi2023montevrain/globale.dart';
import 'package:ipssi2023montevrain/view/seconde_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PermissionPhoto().init();
  //FirestoreHelper().initMusic();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variables
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nickName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController firstName = TextEditingController();


  //méthodes
  SnackBar snackBarShow(){
    return SnackBar(
      padding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
      backgroundColor: Colors.amber,
        duration: const Duration(minutes: 5),
        
        content: Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          height: MediaQuery.of(context).size.height *0.75,
          width: MediaQuery.of(context).size.width,

          child: Column(
            children: [
              TextField(
                controller: lastName,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person,color: Colors.black,),
                    hintText: 'Entrer votre nom',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),

                  )
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: firstName,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person,color: Colors.black,),
                    hintText: 'Entrer votre prénom',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),

                    )
                ),
              ),
              const SizedBox(height: 15,),

              TextField(
                controller: mail,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail,color: Colors.black,),
                    hintText: 'Entrer votre email',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),

                    )
                ),
              ),
              const SizedBox(height: 15,),

              TextField(
                controller: password,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock,color: Colors.black,),
                    hintText: 'Entrer votre password',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),

                    )
                ),
              ),
              const SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: (){
                ScaffoldMessenger.of(context).clearSnackBars();
                FirestoreHelper().inscription(mail.text, firstName.text, "", lastName.text, password.text).then((value){
                        setState(() {
                          moi = value;
                        });
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return const MySecondePage();
                            }
                        ));

                      }).catchError((){

                      });

              },
                  child: const Text("Enregistrement")
              )
            ],
          ),
        )
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:Stack(
        children: [
          const MyBackground(),
          Padding(
              padding: const EdgeInsets.all(15),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyAnimationController(
                      delay: 1,
                      child: Container(
                        height: 300,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                              image: NetworkImage("https://tse2.mm.bing.net/th?id=OIP.Ja_A16t6HOsvb4DPYB4ZCQHaDY&pid=Api"),
                            fit: BoxFit.fill,
                          )
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),

                    MyAnimationController(
                      delay: 2,
                      child: TextField(

                        controller: mail,
                        decoration: InputDecoration(
                          hintText: "Entrer votre mail",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                        ),
                      ),
                    ),

                    const SizedBox(height: 10,),
                    MyAnimationController(
                      delay: 3,
                      child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Entrer votre password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                        ),
                      ),
                    ),

                    const SizedBox(height: 10,),


                    MyAnimationController(
                      delay: 4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: const StadiumBorder()
                        ),
                          onPressed: (){
                          FirestoreHelper().connect(mail.text, password.text).then((value) {
                            setState(() {
                              moi = value;
                            });
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return const MySecondePage();
                                }
                            ));

                          }).catchError((error){

                          });

                          },
                          child: const Text("Connexion")
                      ),
                    ),
                    const SizedBox(height: 10,),

                    MyAnimationController(
                      delay: 5,
                      child: TextButton(
                          onPressed: (){

                            ScaffoldMessenger.of(context).showSnackBar(snackBarShow());





                          },
                          child: const Text("Inscription")
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )

    );
  }
}
