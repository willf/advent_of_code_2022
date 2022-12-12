from collections import namedtuple

import networkx as nx

Point = namedtuple('Loc', ['r', 'c', 'elevation', 'name'])

def elevation_from_letter(letter):
    if letter == 'S':
        letter = 'a'
    elif letter == 'E':
        letter = 'z'
    if 'a' <= letter <= 'z':
      return ord(letter) - ord('a')
    else:
      raise ValueError(f"Invalid elevation: {letter}")

def create_tuple_from_rcl(row, col, elevation):
    if elevation == 'S':
        name = 'S'
    elif elevation == 'E':
        name = 'E'
    else:
        name = f"({row}, {col})"
    elevation = elevation_from_letter(elevation)
    return Point(row, col, elevation, name)


# Read the input, which is a grid of of rows and columns of letters.
# The grid is a directed graph, where each node is a Point.
# The edges are the paths between Points.
# The start node is the Point with the name 'S'
# The end node is the Point with the name 'E'
# There is an edge between two Points if the elevation of the first Point
# is within 1 of the elevation of the second Point.
def create_graph(input):
    graph = nx.DiGraph()
    grid = []
    start = None
    end = None
    for row, line in enumerate(input):
        grid_line = []
        grid.append(grid_line)
        for col, elevation in enumerate(line):
            point = create_tuple_from_rcl(row, col, elevation)
            graph.add_node(point)
            grid_line.append(point)
            if point.name == 'S':
                start = point
            elif point.name == 'E':
                end = point
    for row, line in enumerate(grid):
        for col, point in enumerate(line):
            for r, c in [(row-1, col), (row, col-1), (row, col+1), (row+1, col)]:
                if 0 <= r < len(input) and 0 <= c < len(line):
                    other = grid[r][c]
                    if (point.elevation + 1) - other.elevation >= 0:
                        #print("Adding edge", point.elevation, other.elevation)
                        graph.add_edge(point, other)
    return graph, start, end



def read_input():
    with open('input.txt') as f:
        return [line.strip() for line in f]

def read_graph():
    return create_graph(read_input())

def shortest_path_or_none(graph, start, end):
    try:
        return nx.shortest_path(graph, start, end)
    except nx.NetworkXNoPath:
        return None

def main():
    print("Part 1")
    graph, start, end = read_graph()
    path = nx.shortest_path(graph, start, end)
    # print(''.join(point.name for point in path))
    print(f"Length: {len(path)-1}")

    print("Part 2")
    # get all the points with elevation 0
    points = [point for point in graph.nodes if point.elevation == 0]
    # find the shortest path from each of those points to the end
    paths = [shortest_path_or_none(graph, point, end) for point in points]
    # remove the paths that don't exist
    paths = [path for path in paths if path is not None]
    # list the starting point and the length of the path for each path
    path_lengths = [(path[0], len(path)-1) for path in paths]
    # sort the paths by length
    path_lengths.sort(key=lambda x: x[1])
    # print the starting points of all the paths
    # print the length of shortest path
    print(path_lengths[0][1])
if __name__ == '__main__':
    main()
