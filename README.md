# User

## association
- has_many :prototypes, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy

## columns
- name        :string, null: false
- email       :string, null: false, unique: true
- password    :string, null: false
- member      :text
- profile     :text
- works       :text
- user_image  :string


# Prototype

## association
- belongs_to :user
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :prototype_images, dependent: :destroy

## columns
- title           :string, null: false
- catch_copy      :string
- text            :string
- user            :references, foreign_key :true
- likes_count     :integer, default: 0 

# Prototype_image

## association
- belongs_to :prototype

## columns
- image           :string, null: false
- image_type      :integer {main: 0, sub: 1}, null: false
- prototype       :references, foreign_key :true


# Comments

## association
- belongs_to :prototype
- belongs_to :user

## columns
- content        :string, null: false
- user           :references, foreign_key :true
- prototype      :references, foreign_key :true


# likes

## association
- belongs_to :prototype, counter_cache: :likes_count
- belongs_to :user


## columns
- user          :references, foreign_key :true
- prototype     :references, foreign_key :true
