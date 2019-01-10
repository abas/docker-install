function b () {
    echo $1
}

function a () {
    b $1
}


a "anone"