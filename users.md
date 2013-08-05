User model
==========

 - devise fields (hided)
 - username :string
 - display_name :string
 - reputation :integer (hided)
 - banned_until
 - bio
	- location :string
	- website :string
	- real_name :string
	- about :text
 - concerns
	- bannable
    - roleable
    - flagable

Поле `reputation` является скрытым и служит для обозначения роли пользователя. Значение устанавливается администраторами и не зависит от действий пользователя.

User roles
==================

 * guest (0; access level: everyone)
	* read public namespaces
    * read tags
    * read user profiles
 * registered user (100; access level: registered)
	* read comments
	* read ratings
	* read forums
	* read messages in public rooms
	* manage own messages
 * community member (500; access level: members)
	* write member namespaces
    * write comments
    * edit own comments
    * rate pages
    * flag users
    * flag pages
    * flag comments
 * established member (2k)
 	* write public namespaces
 * trusted member (5k; access level: trusted)
	* create&edit tags
    * create public rooms
 * community moderator (15k; access level: staff)
 	* read warnings
	* read flags
	* write warnings
	* ban users
    * manage tags
	* manage rooms
    * delete comments
	* read additional user info
 * community administrator (30k)
	* nice hat























