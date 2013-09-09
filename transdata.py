#-*- coding: utf-8 -*-
import pymongo
import re

yh_re = re.compile('""')
conn = pymongo.Connection("localhost")
mydb = conn["train_sample"]

buffer_size = 30*1024*1024

def read_file(filename):
    tmp_file = open(filename, "r")
    _data = tmp_file.read(buffer_size)
    buffered = ""
    while _data:
        lines = (buffered + _data).split("\r")
        for line_str in lines[:-1]:
            parse_one_line(line_str)
        buffered = lines[-1]
        _data = tmp_file.read(buffer_size)

    if buffered:
        parse_one_line(buffered)

def parse_one_line(line_str):
    _data = yh_re.sub("", line_str)
    items = _data.split('",')
    if len(items) != 4:
        print len(items)
        print line_str
    else:
        export_to_mongo(items)
        

def export_to_mongo(items):
    mydb.train_data.insert({"_id": items[0], "title":items[1], "content":items[2], "tags":items[3]})

if __name__ == "__main__":
    read_file("Train_sample.csv")

