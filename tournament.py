#!/usr/bin/env python
# 
# tournament.py -- implementation of a Swiss-system tournament
#

"""
SQL query commands needed to manipulate database records:
conn = connect()
c = conn.cursor()
c.execute("your query;")
conn.commit() #only needed for create, update or delete
conn.close() 
"""


import psycopg2


def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament")



def deleteMatches():
    """Remove all the match records from the database."""
    conn = connect("dbname=tournament")
	c = conn.cursor()
	c.execute("DELETE FROM matches;")
    conn.commit() 
    conn.close()


def deletePlayers():
    """Remove all the player records from the database."""
    conn = connect("dbname=tournament")
	c = conn.cursor()
	c.execute("DELETE FROM players;")
    conn.commit() 
    conn.close()


def countPlayers():
    """Returns the number of players currently registered."""
    conn = connect("dbname=tournament")
	c = conn.cursor()
	c.execute("SELECT count(*) FROM players;")
    player_count = c.fetchall()
    conn.close()
    return player_count


def registerPlayer(name):
    """Adds a player to the tournament database.
  
    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)
  
    Args:
      name: the player's full name (need not be unique).
    """
    conn = connect("dbname=tournament")
	c = conn.cursor()
	c.execute("INSERT INTO players(name) VALUES (name);")
    conn.commit() 
    conn.close()


def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or a player
    tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    conn = connect("dbname=tournament")
	c = conn.cursor()
	c.execute("SELECT matches_by_player.name, wins_by_player.win_count, matches_by_player.match_count FROM matches_by_player LEFT JOIN wins_by_player ON matches_by_player.id = wins_by_player.id ORDER BY wins_by_player.win_count DESC;") 
    standings = c.fetchall()
    conn.close()
    return standings

def reportMatch(winner, loser):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost
    """
    conn = connect("dbname=tournament")
	c = conn.cursor()
    match_id = c.execute("SELECT id FROM match WHERE (player1_id = %s AND player_2 = %s) OR (player1_id = %s AND player_2 = %s);" % (winner, loser, loser, winner)) #need to determine which match to update...we know no teams play twice
	c.execute("UPDATE matches SET status = 'played', winner = %s, loser = %s WHERE id = %s;" % (winner, loser, match_id)) 
    conn.close()

 
def swissPairings():
    """Returns a list of pairs of players for the next round of a match.
  
    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.
  
    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """


