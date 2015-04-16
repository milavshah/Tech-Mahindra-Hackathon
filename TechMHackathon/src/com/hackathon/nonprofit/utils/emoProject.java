package com.hackathon.nonprofit.utils;

public class emoProject {

	    int solution(int[] A, int X) {
	        int N = A.length;
	        if (N == 0) {
	            return -1;
	        }
	        int l = 0;
	        int r = N - 1;
	        while (l < r) {
	            int m = ((l+r)%2==0 || l==0) ? (l+r)/2 : ((l + r) / 2 )+1;
	            if (A[m] > X) {
	                r = m - 1;
	            } else {
	                l = m;
	            }
	        }
	        if (A[l] == X) {
	            return l;
	        }
	        return -1;
	    }
	    
	    public static void main(String[] args) {
			// TODO Auto-generated method stub
	    	emoProject de = new emoProject();
			
//			String b = de.reverseWords("Hi what are yuou  kdkd");
			int a[]={1,3,4,5};
			int b = de.solution(a,2);

	//}
			System.out.println(b);
		}
}
