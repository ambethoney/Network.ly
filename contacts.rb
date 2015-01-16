require 'redis'

class Contacts

  def initialize
    @contacts = Redis.new
  end

  def contact_info(f_name, l_name, headline, email)
    @contacts.hmset("my_contacts#{@id}", "contact_f_name", "@contact_f_name", "contact_l_name", "@contact_l_name", "contact_headline", "contact_headline", "contact_email", "@contact_email")
  end

  def show_contacts(person)
    @contacts.lrange "contacts_list#{@name}", 0, -1
  end


end #ends Contacts
