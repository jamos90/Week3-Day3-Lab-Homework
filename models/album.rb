require('pg')
require_relative('../db/sql_runner')

class Album

  attr_accessor :album_name, :genre, :customer_id
  attr_reader :id

  def initialize(options)
    @album_name = options['album_name']
    @genre = options['genre']
    @artist_id = options ['artist_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO albums
    (
      album_name,
      genre
    ) VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@album_name, @genre]
    new_album = SqlRunner.run(sql, values)
    @id = new_album[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map {|albums| Album.new(albums) }
  end


end


  #
  # def self.delete_all()
  #   db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
  #   sql = "DELETE FROM pizza_orders"
  #   db.prepare("delete_all", sql)
  #   db.exec_prepared("delete_all")
  #   db.close()
  # end
  #
  # def customer()
  #   sql = "SELECT * FROM customers WHERE id = $1"
  #   values = [@customer_id]
  #   customers = SqlRunner.run(sql, values).first
  #   return Customer.new(customer)
  # end
