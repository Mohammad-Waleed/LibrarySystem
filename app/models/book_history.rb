class BookHistory < ApplicationRecord
  before_destroy :book_issue_fail_mail

  before_update :issue_success_mail, if: :start_date_changed?

  belongs_to :book
  belongs_to :issuer

  validates :book_id, :issuer_id, presence: { message: 'This field is required' }

  private

    def book_issue_fail_mail
      IssuerMailer.book_issue_fail(self.issuer_id, self.book_id).deliver_now!
    end

    def book_issue_success_mail
       IssuerMailer.book_issue_success(self.issuer_id, self.book_id).deliver_now!
    end
end
