#define fuction to streamline conversion to dataframe for testing 
def reframe(type_input, query):
    #sq fro sqlite
    if  type_input == "sq":
        df = pd.DataFrame(sqlite_cur.execute(query).fetchall())
        df.columns = [i[0] for i in sqlite_cur.description]
    #ps for postgre
    elif type_input == "ps":
        df = pd.DataFrame(cur.execute(query).fetchall())
        df.columns = [i[0] for i in cur.description]
    return df