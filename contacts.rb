require 'redis'

class Contacts

  def initialize
    @contacts = Redis.new
  end

  def contact_info(person, f_name, l_name, headline)
    @contacts.lpush "contacts_list#{@name}", f_name, l_name, headline
  end

  def show_contacts(person)
    @contacts.lrange "contacts_list#{@name}", 0, -1
  end
end #ends Contacts
