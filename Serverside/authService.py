import DataCrunch
import pyrebase

config = DataCrunch.config

authKey = {
    "apiKey" : config.get("apiKey"),
    "authDomain" : config.get("authDomain"),
    "databaseURL" : config.get("databaseURL"),
    "projectId": config.get("projectId"),
    "storageBucket" : config.get("storageBucket"),
    "messagingSenderId" : config.get("messagingSenderId"),
    "appId" : config.get("appId")
}

firebase = pyrebase.initialize_app(authKey)

# Our Database
db = firebase.database()

#TEST: -- Test for checking an item on the database
query = db.child("/Graphing Test/Points").get()
print(query.val())

### Note: Don't forget to create a Guard for Authentication ###
# Mark: -- Login
# Mark: -- Logout
# Mark: -- Current User Observable
# MARK: -- Registration

## Refering to this pyrebase function

"""
def signupUser(email: string, password: string): Promise<any> {
    return firebase
      .auth()
      .createUserWithEmailAndPassword(email, password)
      .then((newUserCredential: firebase.auth.UserCredential) => {
        firebase
          .firestore()
          .doc(`/userProfile/${newUserCredential.user.uid}`)
          .set({ email });
      })
      .catch(error => {
        console.error(error);
        throw new Error(error);
      });
      
    }
    """

    # Mark: -- Write to Database
    ### Notes: Check Trello for database fields ###

    # Mark: -- Get value from Database

    # Mark: -- Get Student Progress

    # Mark: -- Display Student Pregress

