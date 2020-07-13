class IssuerMailer < ApplicationMailer
  def welcome(issuer)
    @issuer = issuer
    mail(to: @issuer.email, subject: 'Sign Up Confirmation')
  end

  def book_issue_success(issuer, book)
    @issue = Issuer.find_by(id: issuer)
    @book = Book.find_by(id: book)
    mail(to: @issue.email, subject: "Book #{@book.title} Issue Success")
  end

  def book_issue_fail(issuer, book)
    @issue = Issuer.find_by(id: issuer)
    @book = Book.find_by(id: book)
    mail(to: @issue.email, subject: "Book #{@book.title} Issue Failure")
  end
end
