/*
 * C++ Program to check if Complete Matching exists or not
 */
#include <iostream>
#include <cstdlib>
#include <cmath>
using namespace std;
/*
 * Adjacency Matrix Class
 */
class AdjacencyMatrix
{
    private:
        int n;
        int **adj;
        bool *visited;
    public:
        AdjacencyMatrix(int n)
        {
            this->n = n;
            visited = new bool [n];
            adj = new int* [n];
            for (int i = 0; i < n; i++)
            {
                adj[i] = new int [n];
                for(int j = 0; j < n; j++)
                {
                    adj[i][j] = 0;
                }
            }
        }
        /*
         * Adding Edge to Graph
         */
        void add_edge(int origin, int destin)
        {
            if( origin > n || destin > n || origin < 0 || destin < 0)
            {
                cout<<"Invalid edge!\n";
            }
            else
            {
                adj[origin - 1][destin - 1] = 1;
            }
        }
        /*
         * Print the graph
         */
        void display()
        {
            int i,j;
            for(i = 0;i < n;i++)
            {
                for(j = 0; j < n; j++)
                    cout<<adj[i][j]<<"  ";
                cout<<endl;
            }
        }

        int connected(int i, int j)
        {
            if(adj[i][j]==1)
                return 1;
            else
                return 0;
        }
};

int ConnectedSet(int array[],int size,int n, AdjacencyMatrix am){
    int i,j,connectedness;
    connectedness=0;
    for(i=1;i<=n;i++)
        {   for (j=1;j<=size;j++)
                {
                    //cout << array[j] << " ";
                    //cout << endl;
                    int index;
                    index = array[j];
                    if(am.connected(index-1,i-1)){
                        connectedness++;
                        break;
                    }
                }
        }

    if(connectedness>=size)
        return 1;
    else
        return 0;

}

void printPowerset (int n, AdjacencyMatrix am){
    int stack[n+1],k,ctr, val;

    stack[0]=0; /* 0 is not considered as part of the set */
    k = 0;
    ctr=0;
    val=1;

    while(1){

        if (stack[k]<n){
            stack[k+1] = stack[k] + 1;
            k++;
        }

        else{
            stack[k-1]++;
            k--;
        }

        if (k==0)
            break;

        val = ConnectedSet(stack,k,n,am);

        if(val==0){
            cout<<"\n\n-------------------------\n\n";
            cout<<"\n\nMATCHING DOES NOT EXIST\n\n";
            cout<<"\n\n-------------------------\n\n";
            break;
        }
        ctr++;
    }
    if(ctr==(pow(2,n)-1)){
        cout<<"\n\n---------------\n";
        cout<<"\n\nMATCHING EXIST\n\n";
        cout<<"\n---------------\n\n";

    }

    return;
}

/*
 * Main
 */
int main()
{
    int nodes, max_edges, origin, destin;
    cout<<"Enter number of Girls: ";
    cin>>nodes;

    if(nodes>10)
        {
            cout<<"\n\nWell you got a big number there. You have to enter at least one choice for each girl for matching to exist.\n\n";
        }
    else
        {
            cout<<"\n\nRemember you have to enter at least one choice for each girl for matching to exist\n\n";
        }

    AdjacencyMatrix am(nodes);
    max_edges = nodes * nodes;

    for (int i = 0; i < nodes; i++)
    {
        cout<<"Enter choice for Girl "<<i+1<<" : ";
        for(int j=0; j < nodes; j++)
            {   if(j==0)
                cin>>destin;

                else
                {   cout<<"Enter -1 to stop filling choices for Girl "<<i+1<<" : ";
                    cin>>destin;

                    if(destin == -1)
                        break;
                }

                am.add_edge(i+1, destin);
            }
        cout<<endl;
    }
    am.display();
    printPowerset(nodes, am);
    return 0;
}