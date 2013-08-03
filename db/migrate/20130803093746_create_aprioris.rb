class CreateAprioris < ActiveRecord::Migration
  def change
    create_table :aprioris do |t|
      t.string :lhs
      t.string :rhs
      t.float :support
      t.float :confidence
      t.float :lift

      t.timestamps
    end
  end
end
