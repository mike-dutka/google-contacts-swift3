//
//  Common.swift
//  Google Contacts Viewer
//
//  Created by Kalyan Vishnubhatla on 12/18/16.
//
//

let MainScreenWidth: CGFloat = UIScreen.main.bounds.size.width
let MainScreenHeight: CGFloat = UIScreen.main.bounds.size.height


// Google constants
let Scope = "https://www.googleapis.com/auth/contacts.readonly"
let ContactsEndPointURLString = "https://www.google.com/m8/feeds/contacts/default/thin?max-results=10000"
let ClientId = "813589489238-pl0vt4n23smnrpipm2b4foosk9cq5b5h.apps.googleusercontent.com"

// UserDefault Keys
let UserAccessToken = "UserAccessToken"

// Notification Keys
let DataChanged: String = "com.contactshandler.DataChanged"
