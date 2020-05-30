const Express = require('express');
const mongoose = require('mongoose');
const app = Express();



// const MongoClient = require('mongodb').MongoClient;
// const uri = "mongodb+srv://shantanu:<shantanu>@shan-xubwn.mongodb.net/test?retryWrites=true&w=majority";
// const client = new MongoClient(uri, { useNewUrlParser: true });
// client.connect(err => {
//   const collection = client.db("test").collection("devices");
//   collection.insertOne({a:1},(res)=>{
//     console.log(res);
//   });
//   // perform actions on the collection object
//   client.close();
// });




app.listen(3000,()=>{
    console.log("Server is started on 3000");
});

//Schemas

const userSchema = {
    name:String,
    email:String,
    passsword:String
}

mongoose.connect("mongodb+srv://shantanu:<shantanu>@shan-xubwn.mongodb.net/test?retryWrites=true&w=majority",{ useNewUrlParser: true });


const Users = mongoose.model('userList',userSchema);


app.get('',(request,response)=>{
    // const pk = new Users({  name:"String",
    //     email:"String",
    //     passsword:"String"});
    // pk.save((err,res)=>{
    //     if(err){
    //         console.log(err);
    //     }else{
    //         response.status(201).json({
    //             message:"h bhjgbjbhbgvf gjg fghjjg",
    //             user:res
    //         });
    //     }
    // });
    Users.insertMany([{ name:"String", email:"String",passsword:"String"},{ name:"String", email:"String",passsword:"String"}]);
    response.send('Hello');
    
});


app.get('/user',(request,response)=>{
    // Users.find((err,res)=>{
    //         response.send(res);
    // });
});