# README
LMS has the following modules

    1. We have a Library with a Fine amount. (only admin can access)
    2. Can have multiple libraries.
    3. One manager cannot be an employee of any other library.
    4. There are Following Users (every user can perform login functionality.):
        a. Admin:
            i. He has an Email and password.
            ii. He can manage Library Fine Amount.
            iii. He can manage the manager and issuer status whether active or inactive.
            iv. He can edit or delete any user.
            v. He can create a manager account and upon creation welcome email should be sent to the manager email.
            vi. He can approve or reject the issuer request for account creation.
            vii. He can view all managers and issuers.
        b. Manager:
            i. He has an Email, password, profile picture and status.
            ii. He can create books in the Library.
            iii. He can change the status of the Book.
            iv. He can approve or reject the book issue request from an issuer, in both cases an email should be dispatched to the requested user.
        c. Issuer:
            i. He has First Name, Last Name, Email, Password, Profile Picture, Status and Balance(Number of books).
            ii. He can request an account.
            iii. He can perform login functionality after account confirmation.
            iv. He can see all the books available in the Library.
            v. He can place a request for issuing any book.
            vi. He can return a book after 1 month, if he fails to return the issued book, he will charge a fine of everyday which is set by the admin.

    5. Book:
        a. It has title, isbn, author, year, genre, number of copies, picture(can be more than 1) and status.
        b. It will always be issued for 1 month.
        c. Everybook should have some history like it is issued to this user from this date to this date.
        d. Issuers and Managers can search for books.

