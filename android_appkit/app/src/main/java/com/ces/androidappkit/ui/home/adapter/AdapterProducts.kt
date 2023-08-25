package com.ces.androidappkit.ui.home.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.ces.androidappkit.databinding.ItemProductsBinding
import com.ces.androidappkit.ui.home.model.ModelProduct

// Using ListAdapter and Diff Utils
class AdapterProducts() :
    ListAdapter<ModelProduct, AdapterProducts.ViewHolder>(ListItemCallback()) {

    var onItemClick: ((ModelProduct) -> Unit)? = null
    var onFavouriteClick: ((ModelProduct) -> Unit)? = null

    class ListItemCallback : DiffUtil.ItemCallback<ModelProduct>() {
        override fun areItemsTheSame(
            oldItem: ModelProduct,
            newItem: ModelProduct
        ): Boolean {
            return oldItem == newItem
        }

        override fun areContentsTheSame(
            oldItem: ModelProduct,
            newItem: ModelProduct
        ): Boolean {
            return oldItem.id == newItem.id
        }
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = getItem(position)
        holder.binding.model = item
    }

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): ViewHolder {
        val view = ItemProductsBinding.inflate(LayoutInflater.from(parent.context))
        return ViewHolder(view)
    }

    inner class ViewHolder(val binding: ItemProductsBinding) :
        RecyclerView.ViewHolder(binding.root) {
        init {
            binding.ivHeart.setOnClickListener {
                onFavouriteClick?.invoke(getItem(adapterPosition))
            }
            binding.root.setOnClickListener {
                onItemClick?.invoke(getItem(adapterPosition))
            }
        }
    }

}